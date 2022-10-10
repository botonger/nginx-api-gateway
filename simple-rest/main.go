package main

import (
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/gorilla/mux"
)

func main() {
	router := mux.NewRouter()

	router.HandleFunc("/", func(writer http.ResponseWriter, request *http.Request) {
		writer.Write([]byte(fmt.Sprintf("Hello %s from %s\n", "anonymous", request.Host)))
	}).Methods("GET")

	router.HandleFunc("/{some:[-a-zA-z_0-9.]+}", func(writer http.ResponseWriter, request *http.Request) {
		v := mux.Vars(request)
		some := v["some"]

		writer.Write([]byte(fmt.Sprintf("Hello %s from %s\n", some, request.Host)))
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
