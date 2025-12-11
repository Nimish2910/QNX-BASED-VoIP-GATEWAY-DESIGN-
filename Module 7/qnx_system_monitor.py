import os

def menu():
    print("\n--- QNX SYSTEM MONITOR ---")
    print("1. Processes")
    print("2. Kernel Info")
    print("3. Disk Usage")
    print("4. Uptime")
    print("5. CPU Summary")
    print("6. Memory Summary")
    print("0. Exit")

while True:
    menu()
    choice = input("Enter choice: ")

    if choice == "1":
        os.system("ps -A")
    elif choice == "2":
        os.system("uname -a")
    elif choice == "3":
        os.system("df -h")
    elif choice == "4":
        os.system("uptime")
    elif choice == "5":
        os.system("pidin cpu")
    elif choice == "6":
        os.system("pidin mem")
    elif choice == "0":
        print("Goodbye.")
        break
    else:
        print("Invalid choice.")

    input("\nPress Enter to continue...")
    os.system("clear")