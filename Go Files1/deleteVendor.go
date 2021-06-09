package main

import (
	"database/sql"
	"fmt"
	"net/http"

	_ "github.com/mattn/go-sqlite3"
)

func delVendor(respwr http.ResponseWriter, req *http.Request){
	keys, ok := req.URL.Query()["key"]

	if !ok || len(keys[0]) < 1 {
		//log.Println("Url Param 'key' is missing")
		return
	}

	database, _ := sql.Open("sqlite3", "./petportal.db")

	key := keys[0]
	var tempmail = string(key) 
	fmt.Println(tempmail)
	stmt, err := database.Prepare("delete from vendor where vendor_email=?")

    fmt.Println(err)

        res, e := stmt.Exec(tempmail)
        fmt.Println(e)

        affect, err := res.RowsAffected()
        fmt.Println(err)

        fmt.Println(affect)

        database.Close()
	

}