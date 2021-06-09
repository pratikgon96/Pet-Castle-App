package main

import (
	"database/sql"
	"fmt"
	"strconv"
	"strings"

	_ "github.com/mattn/go-sqlite3"
)

type notification struct {
	notification_id       string
	owner_id              string
	vendor_id             string
	notification_category string
	notification_text     string
}

func Addnotification(who string, whv string, differ string) {
	database, _ := sql.Open("sqlite3", "./petportal.db")
	statement, _ := database.Prepare("CREATE TABLE IF NOT EXISTS notification (notification_id Text Primary Key, owner_id Text, vendor_id Text, notification_category Text, notification_text text, FOREIGN KEY (owner_id) REFERENCES owner(owner_id), FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id))")
	x1, y1 := statement.Exec()
	fmt.Println(y1)
	fmt.Println(x1)
	var not notification
	var z string
	temp := database.QueryRow("SELECT notification_id, owner_id, vendor_id, notification_category, notification_text FROM notification ORDER BY notification_id DESC")
	temp.Scan(&not.notification_id, &not.owner_id, &not.vendor_id, &not.notification_category, &not.notification_text)
	if not.notification_id != "" {

		x := strings.Split(not.notification_id, "n")
		v, _ := strconv.Atoi(x[1])
		z = "n" + strconv.Itoa((v + 1))

		fmt.Println("the z is " + z)

		if differ == "o" {
			z = who + "--" + whv + "," + "n" + strconv.Itoa((v + 1))
		}
		if differ == "v" {
			z = whv + "--" + who + "," + "n" + strconv.Itoa((v + 1))

		}

		//fmt.Println("the created id is " + z)
	}
	if not.notification_id == "" {
		z = "n1"
	}
	var not1 notification
	var not2 notification
	not1 = notification{notification_id: z, owner_id: who, vendor_id: whv, notification_category: "payment", notification_text: "payment is done "}
	not.notification_id = z
	fmt.Println(not.notification_id)
	fmt.Println("Shard")
	statement1, _ := database.Prepare("INSERT INTO notification (notification_id, owner_id, vendor_id, notification_category, notification_text) VALUES (?, ?, ?, ?, ?)")
	x, y := statement1.Exec(not1.notification_id, not1.owner_id, not1.vendor_id, not1.notification_category, not1.notification_text)
	fmt.Println(y)
	fmt.Println(x)
	rows, _ := database.Query("SELECT notification_id, owner_id, vendor_id, notification_category, notification_text FROM notification ORDER BY notification_id DESC")
	for rows.Next() {
		//fmt.Println("Shard")
		rows.Scan(&not2.notification_id, &not2.owner_id, &not2.vendor_id, &not2.notification_category, &not2.notification_text)
		fmt.Println(not2.notification_id + " " + not2.owner_id + " " + not2.vendor_id + " " + not2.notification_category + " " + not2.notification_text)
		//fmt.Println("Sword")
	}
	database.Close()
}
// func main() {
// 	addnotification("o1", "v1")
// 	//fmt.Println(time.Now().Date())

// }
