#!/usr/bin/env python3
import http.server
import socketserver
import os
import time

PORT = 8080
event_log = []     # rolling access log

def get_cpu():
    return os.popen("pidin cpu").read().strip()

def get_mem():
    return os.popen("pidin mem").read().strip()

def get_uptime():
    return os.popen("uptime").read().strip()

class Handler(http.server.SimpleHTTPRequestHandler):

    # ---------------------------------------
    # Log every request
    # ---------------------------------------
    def log_event(self, path):
        timestamp = time.strftime("%Y-%m-%d %H:%M:%S")
        event_log.append(f"[{timestamp}] Accessed {path}")
        if len(event_log) > 20:
            event_log.pop(0)

    # ---------------------------------------
    # HTTP GET
    # ---------------------------------------
    def do_GET(self):

        # ---------- HOME PAGE (still HTML) ----------
        if self.path == "/":
            self.log_event("/")
            homepage = (
                "QNX IoT Telemetry Service\n"
                "Available endpoints:\n"
                "/status\n"
                "/logs\n"
                "/ping\n"
                "/metric/cpu\n"
                "/metric/memory\n"
                "/metric/uptime\n"
            )
            self.respond_text(homepage)
            return

        # ---------- STATUS ----------
        if self.path == "/status":
            self.log_event("/status")
            status = (
                "=== System Status ===\n\n"
                f"{get_cpu()}\n\n"
                f"{get_mem()}\n\n"
                f"{get_uptime()}\n"
            )
            self.respond_text(status)
            return

        # ---------- LOGS ----------
        if self.path == "/logs":
            self.log_event("/logs")
            logs = "\n".join(event_log)
            self.respond_text("=== Access Log ===\n" + logs)
            return

        # ---------- PING ----------
        if self.path == "/ping":
            self.log_event("/ping")
            self.respond_text("pong")
            return

        # ---------- METRIC: CPU ----------
        if self.path == "/metric/cpu":
            self.log_event("/metric/cpu")
            self.respond_text(get_cpu())
            return

        # ---------- METRIC: MEMORY ----------
        if self.path == "/metric/memory":
            self.log_event("/metric/memory")
            self.respond_text(get_mem())
            return

        # ---------- METRIC: UPTIME ----------
        if self.path == "/metric/uptime":
            self.log_event("/metric/uptime")
            self.respond_text(get_uptime())
            return

        self.send_error(404, "Endpoint not found")

    # ---------------------------------------
    # Respond with plain text (for curl output)
    # ---------------------------------------
    def respond_text(self, body):
        self.send_response(200)
        self.send_header("Content-Type", "text/plain")
        self.end_headers()
        self.wfile.write((body + "\n").encode())


# ---------------------------------------
# Run server
# ---------------------------------------
socketserver.TCPServer.allow_reuse_address = True

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"QNX IoT Telemetry Service running on port {PORT}")
    httpd.serve_forever()
