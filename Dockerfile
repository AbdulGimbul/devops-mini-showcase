# Stage 1: Build the Go application
FROM golang:1.21-alpine AS builder
ENV GOTOOLCHAIN=auto
WORKDIR /app
COPY . .
# Build the Go binary
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/main .

# Stage 2: Create the final, small image
FROM alpine:latest
WORKDIR /app
# Copy only the compiled binary from the builder stage
COPY --from=builder /app/main .
# Expose the port the app runs on
EXPOSE 8080
# Command to run the application
CMD ["/app/main"]