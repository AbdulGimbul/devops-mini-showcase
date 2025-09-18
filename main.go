package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	// Read a welcome message from an environment variable
	// This will be set by our Kubernetes ConfigMap!
	welcomeMessage := os.Getenv("WELCOME_MESSAGE")
	if welcomeMessage == "" {
		welcomeMessage = "Hello from default config!"
	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, welcomeMessage)
	})

	log.Println("Starting server on port 8080...")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}
