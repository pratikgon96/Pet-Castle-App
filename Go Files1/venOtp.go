package main

import (
	"fmt"
	"net/http"
	"net/smtp"
)

// type Otp struct {
// 	Vendor_otp   string `json:"Vendor_otp"`
// 	Vendor_email string `json:"Vendor_email"`
// }

func sendOtp(respwr http.ResponseWriter, req *http.Request) {

	keys, ok := req.URL.Query()["key"]

	if !ok || len(keys[0]) < 1 {
		//log.Println("Url Param 'key' is missing")
		return
	}

	keys1, ok := req.URL.Query()["key1"]

	if !ok || len(keys1[0]) < 1 {
		//log.Println("Url Param 'key' is missing")
		return
	}

	//var obj ownerDisp
	key := keys[0]
	key1 := keys1[0]
	// Sender data.
	from := "demoshouryatest@gmail.com"
	password := "Demo@1234"

	// Receiver email address.
	to := []string{
		key,
	}

	// smtp server configuration.
	smtpHost := "smtp.gmail.com"
	smtpPort := "587"

	// Message.
	message := []byte("This is a test email message." + key1)

	// Authentication.
	auth := smtp.PlainAuth("", from, password, smtpHost)

	// Sending email.
	err := smtp.SendMail(smtpHost+":"+smtpPort, auth, from, to, message)
	if err != nil {
		fmt.Println(err)
		return
	}
	OwnerJson := "Email Sent Successfully!"

	respwr.Write([]byte(OwnerJson))
	fmt.Println("Email Sent Successfully!")
	defer req.Body.Close()
}
