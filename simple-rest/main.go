package main

import (
	"fmt"
	"log"
	"math/rand"
	"net/http"
	"time"

	"github.com/gorilla/mux"
)

func main() {
	router := mux.NewRouter()

	router.HandleFunc("/", func(writer http.ResponseWriter, request *http.Request) {
		writer.Write([]byte(fmt.Sprintf("Hello anonymous from %s\n", request.Host)))
	}).Methods("GET")

	router.HandleFunc("/hello/{some:[-a-zA-z_0-9.]+}", func(writer http.ResponseWriter, request *http.Request) {
		v := mux.Vars(request)
		some := v["some"]

		countries := []string{"Kysrgizstan", "India", "Congo", "Germany", "Bolivia"}

		writer.Write([]byte(fmt.Sprintf("Hello %s from %s: %s\n", some, countries[rand.Intn(5)], request.Host)))
	}).Methods("GET")

	port := 8080
	s := &http.Server{
		Addr:           fmt.Sprintf(":%d", port),
		ReadTimeout:    10 * time.Second,
		WriteTimeout:   10 * time.Second,
		MaxHeaderBytes: http.DefaultMaxHeaderBytes,
		Handler:        router,
	}

	log.Printf("Listening on port: %d\n", port)
	log.Fatal(s.ListenAndServe())

}
