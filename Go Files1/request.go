package main

import (
	"database/sql"

	_ "github.com/mattn/go-sqlite3"
)

type request struct {
	request_id        string
	owner_id          string
	vendor_id         string
	vendor_license_no string
	request_status    string
}

func seerequest(who string, whv string, whvl string) {
	database, _ := sql.Open("sqlite3", "./petportal.db")
	statement, _ := database.Prepare("CREATE TABLE IF NOT EXISTS request(payment_id Text Primary Key, owner_id Text, vendor_id Text, vendor_license_no Text, request_status Text, FOREIGN KEY (owner_id) REFERENCES owner(owner_id), FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id), FOREIGN KEY (vendor_license_no) REFERENCES vendor(vendor_license_no))")
	statement.Exec()
	database.Close()
}
// func main() {
// 	seerequest("o1", "v1", "12345")
// 	//fmt.Println(time.Now().Date())

// }
