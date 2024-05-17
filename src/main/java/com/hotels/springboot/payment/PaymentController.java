package com.hotels.springboot.payment;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@RestController
public class PaymentController {

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private PrePaymentRepository prePaymentRepository;

	@PostMapping("/payment/prepare")
	public ResponseEntity<?> preparePayment(@RequestBody PrePaymentEntity request) {
		try {
			paymentService.postPrepare(request);
			return ResponseEntity.ok("결제 준비가 완료되었습니다.");
		} catch (IamportResponseException | IOException e) {
			return ResponseEntity.internalServerError().body("서버 오류: " + e.getMessage());
		}
	}

	@PostMapping("/payment/validate")
	public ResponseEntity<?> validatePayment(@RequestBody PaymentDTO request) {
		try {
			IamportResponse<Payment> response = paymentService.validatePayment(request.getImp_uid());
			Payment payment = response.getResponse();

			if (payment != null && payment.getMerchantUid().equals(request.getMerchant_uid())) {
				// DB에서 해당 주문번호의 결제 요청 금액 가져오기
				PrePaymentEntity prePayment = prePaymentRepository.findById(request.getMerchant_uid()).orElse(null);

				if (prePayment != null && prePayment.getAmount().compareTo(payment.getAmount()) == 0) {
					return ResponseEntity.ok("결제가 유효합니다.");
				} else {
					// 금액이 일치하지 않으면 결제 취소
					paymentService.cancelPayment(request.getImp_uid());
					return ResponseEntity.badRequest().body("결제 금액이 일치하지 않아 결제를 취소했습니다.");
				}
			} else {
				return ResponseEntity.badRequest().body("결제가 유효하지 않습니다.");
			}
		} catch (IamportResponseException | IOException e) {
			return ResponseEntity.internalServerError().body("서버 오류: " + e.getMessage());
		}
	}

	@PostMapping("/payment/save")
	public ResponseEntity<?> savePayment(@RequestBody PaymentEntity payment) {
		try {
			PaymentEntity savedPayment = paymentService.savePayment(payment);
			return ResponseEntity.ok(savedPayment.getPayNum());
		} catch (Exception e) {
			return ResponseEntity.internalServerError().body("결제 정보 저장 중 오류가 발생했습니다: " + e.getMessage());
		}
	}

	@RequestMapping("/paidOrder.do")
	public ModelAndView paidOrder(@RequestParam("payNum") String payNum) {
		PaymentEntity payment = paymentService.getPaymentByPayNum(payNum);
		ModelAndView mav = new ModelAndView("/pay/paid_order");
		mav.addObject("payment", payment);
		return mav;
	}

}