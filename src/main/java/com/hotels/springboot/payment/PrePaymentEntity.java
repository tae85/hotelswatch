package com.hotels.springboot.payment;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class PrePaymentEntity {

    @Id
    @Column(name = "merchant_uid")
    private String merchantUid;

    @Column(name = "amount")
    private BigDecimal amount;

    public PrePaymentEntity() {
    }

    public PrePaymentEntity(String merchantUid, BigDecimal amount) {
        this.merchantUid = merchantUid;
        this.amount = amount;
    }

    public String getMerchantUid() {
        return merchantUid;
    }

    public void setMerchantUid(String merchantUid) {
        this.merchantUid = merchantUid;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }
}