package com.toomuchcoding;

import com.jayway.restassured.module.mockmvc.RestAssuredMockMvc;
import com.toomuchcoding.frauddetection.FraudDetectionController;

import org.junit.Before;

public class MvcTest {

	@Before
	public void setup() {
		RestAssuredMockMvc.standaloneSetup(new FraudDetectionController());
	}

	public void assertThatRejectionReasonIsNull(Object rejectionReason) {
		assert rejectionReason == null;
	}
}