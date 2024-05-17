package com.hotels.springboot.payment;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "payments")
public class PaymentEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "pay_num")
	private String payNum;

	@Column(name = "imp_uid")
	private String impUid;

	@Column(name = "paymethod")
	private String paymethod;

	@Column(name = "payproduct")
	private String payproduct;

	@Column(name = "payprice")
	private BigDecimal payprice;

	@Column(name = "guest_name")
	private String guestName;

	@Column(name = "phone")
	private String phone;

	@Column(name = "paydate")
	private LocalDateTime paydate;

	@Column(name = "payperiod")
	private String payperiod;

	@Column(name = "first_name")
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

	@Column(name = "ask")
	private String ask;

	@Column(name = "member_idx")
	private String memberIdx; // 외래 키 참조
}
