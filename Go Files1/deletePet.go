package main

import (
	"database/sql"
	"fmt"
	"net/http"

	_ "github.com/mattn/go-sqlite3"
)

func delPet(respwr http.ResponseWriter, req *http.Request){
	keys, ok := req.URL.Query()["key"]

	if !ok || len(keys[0]) < 1 {
		//log.Println("Url Param 'key' is missing")
		return
	}
	database, _ := sql.Open("sqlite3", "./petportal.db")

	key := keys[0]
	var tempid = string(key)
	//var tempid = "p5"
	fmt.Println(tempid)
	stmt, err := database.Prepare("delete from pets where pet_id=?")
	fmt.Println(err)

        res, e := stmt.Exec(tempid)
        fmt.Println(e)
		fmt.Println("hi")
        affect, err := res.RowsAffected()
        fmt.Println(err)
		fmt.Println("hello")
        fmt.Println(affect)
		fmt.Println("done")
        database.Close()

}