// package main

// import (
// 	"database/sql"
// 	"fmt"

// 	_ "github.com/lib/pq"
// )

// func main() {
// 	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s "+
// 		"password=%s dbname=%s sslmode=disable",
// 		"localhost", 5432, "petcastle", "password", "petportal")
// 	database, er2 := sql.Open("postgres", psqlInfo)
// 	statement, er3 := database.Exec("CREATE TABLE IF NOT EXISTS vendor (vendor_id Text Primary Key, vendor_name Text, vendor_email Text, vendor_service_type Text, vendor_phn_no text, vendor_license_no Text, vendor_password text, vendor_location Text, vendor_status Text, vendor_device Text)")
// 	fmt.Println(database)
// 	fmt.Println(statement)
// 	fmt.Println(er3)

// 	fmt.Println(er2)
// }
package main
