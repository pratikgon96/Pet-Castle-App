package main

import (
	"net/http"
)

// // type Proper2 struct {
// // 	Email    string `json:"Email"`
// // 	Password string `json:"Password"`
// // }

func main() {

	// the information which is to be sent must be in json format
	//hello means the masking like pagename
	http.HandleFunc("/signupowner", AddOwner)
	http.HandleFunc("/loginowner", Login)
	http.HandleFunc("/changePass", changePassword)
	http.HandleFunc("/disppet", DispPet)
	http.HandleFunc("/AddPet", AddPet)
	http.HandleFunc("/editPet", editPetDisp)
	http.HandleFunc("/delPet",delPet)
	http.HandleFunc("/dispown", dispOwner)
	http.HandleFunc("/delowner",delOwner)
	http.HandleFunc("/dispdoc", DisplayDoc)
	http.HandleFunc("/editOwn", editOwnerDisp)
	http.HandleFunc("/review", Addreview)


	http.HandleFunc("/signupvendor", AddVendor)
	http.HandleFunc("/loginvendor", LoginV)
	http.HandleFunc("/changePassV", changePasswordV)
	http.HandleFunc("/dispven", dispVendor)
	http.HandleFunc("/editven",editVenDisp)
	http.HandleFunc("/delvendor",delVendor)
	http.HandleFunc("/dispserv", DispServ)
	http.HandleFunc("/AddService", AddService)
	http.HandleFunc("/sendotp", sendOtp)

	http.ListenAndServe(":8090", nil)

}

// /*func getDat(respwr http.ResponseWriter, req *http.Request) {
// 	fmt.Println("entering the get methods")
// 	//client := &http.Client{}
// 	var data Proper2
// 	dec := json.NewDecoder(req.Body)
// 	err := dec.Decode(&data)
// 	fmt.Println(data.Email)
// 	fmt.Println(err)
// 	defer req.Body.Close()
// 	// req, err := http.NewRequest("GET", "http://192.168.0.9:8080/getur2", nil)
// 	// //fmt.Println(req.Response.StatusCode)
// 	// if err != nil {
// 	// 	fmt.Print(err.Error())
// 	// }
// 	// req.Header.Add("Accept", "application/json")
// 	// req.Header.Add("Content-Type", "application/json")
// 	// resp, err := client.Do(req)
// 	// if err != nil {
// 	// 	fmt.Print(err.Error())
// 	// }
// 	// defer resp.Body.Close()
// 	// bodyBytes, err := ioutil.ReadAll(resp.Body)
// 	// if err != nil {
// 	// 	fmt.Print(err.Error())
// 	// }
// 	// var responseObject http.Response
// 	// json.Unmarshal(bodyBytes, &responseObject)
// 	// fmt.Printf("API Response as struct %+v\n", responseObject)

// 	//var x, y = http.NewRequest(http.MethodGet, "http://192.168.0.9:8080/getur2", nil)

// 	//x, y := http.Get("http://192.168.0.9:8080/getur2")
// 	//fmt.Println(x.StatusCode)
// 	//fmt.Println(x.StatusCode)
// 	//x1, y11 := x.GetBody()
// 	//fmt.Println(y)
//    	//fmt.Println(y11)
// 	//fmt.Println("the data getting printed is ")
// 	//fmt.Println(x1)
// 	//fmt.Println(x.Body)
// 	//http.Post()

// }

// func first(respwr2 http.ResponseWriter, req *http.Request) {

// 	emp2 := &Proper2{Email: "Rocky", Password: "5454"}
// 	e2, y := json.Marshal(emp2)
// 	fmt.Println("the error with json conversion")
// 	fmt.Println(y)
// 	//fmt.Println(err)
// 	fmt.Println(string(e2))
// 	fmt.Fprintf(respwr2, string(e2))
// 	//fmt.Println(respwr2.Header().Set("sending data", "receive it "))
// 	fmt.Println(emp2.Email)
// 	//respwr2.Body.Close()
// 	//fmt.Println(er)
// 	//fmt.Println(n)

// }*/
