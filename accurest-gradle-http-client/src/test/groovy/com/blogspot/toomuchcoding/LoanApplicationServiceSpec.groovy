package com.blogspot.toomuchcoding

import com.blogspot.toomuchcoding.frauddetection.Application
import com.blogspot.toomuchcoding.frauddetection.LoanApplicationService
import com.blogspot.toomuchcoding.frauddetection.model.Client
import com.blogspot.toomuchcoding.frauddetection.model.LoanApplication
import com.blogspot.toomuchcoding.frauddetection.model.LoanApplicationResult
import com.blogspot.toomuchcoding.frauddetection.model.LoanApplicationStatus
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.SpringApplicationContextLoader
import org.springframework.test.context.ContextConfiguration
import spock.lang.Specification

@ContextConfiguration(loader = SpringApplicationContextLoader, classes = Application)
class LoanApplicationServiceSpec extends Specification {

	@Autowired
	LoanApplicationService sut

	def 'should successfully apply for loan'() {
		given:
			LoanApplication application =
					new LoanApplication(client: new Client(pesel: '1234567890'), amount: 123.123)
		when:
			LoanApplicationResult loanApplication = sut.loanApplication(application)
		then:
			loanApplication.loanApplicationStatus == LoanApplicationStatus.LOAN_APPLIED
			loanApplication.rejectionReason == null
	}

	def 'should be rejected due to abnormal loan amount'() {
		given:
			LoanApplication application =
					new LoanApplication(client: new Client(pesel: '1234567890'), amount: 99_999)
		when:
			LoanApplicationResult loanApplication = sut.loanApplication(application)
		then:
			loanApplication.loanApplicationStatus == LoanApplicationStatus.LOAN_APPLICATION_REJECTED
			loanApplication.rejectionReason == 'Amount too high'
	}

}
