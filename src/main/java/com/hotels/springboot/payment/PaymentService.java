package com.hotels.springboot.payment;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.request.PrepareData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import jakarta.annotation.PostConstruct;
import jakarta.transaction.Transactional;

@Service
public class PaymentService {

	private IamportClient api;

	@Autowired
	private PrePaymentRepository prePaymentRepository;

	@Autowired
	private PaymentRepository paymentRepository;

	@Value("${imp.api.key}")
	private String apiKey;

	@Value("${imp.api.secretkey}")
	private String secretKey;

	@PostConstruct
	public void init() {
		this.api = new IamportClient(apiKey, secretKey);
	}

	public void postPrepare(PrePaymentEntity request) throws IamportResponseException, IOException {
		
		PrepareData prepareData = new PrepareData(request.getMerchantUid(), request.getAmount());
		// 사전 등록 API
		api.postPrepare(prepareData); 

		// 주문번호와 결제예정 금액 DB 저장
		prePaymentRepository.save(request); 
	}

	public IamportResponse<Payment> validatePayment(String impUid) throws IamportResponseException, IOException {
		// 결제 검증 API
		return api.paymentByImpUid(impUid); 
	}

	public void cancelPayment(String impUid) throws IamportResponseException, IOException {
		CancelData cancelData = new CancelData(impUid, true);
		
		// 결제 취소 API
		api.cancelPaymentByImpUid(cancelData); 
	}

	@Transactional
	public PaymentEntity savePayment(PaymentEntity payment) {
		return paymentRepository.save(payment);
	}

	public PaymentEntity getPaymentByPayNum(String payNum) {
		return paymentRepository.findByPayNum(payNum);
	}

}