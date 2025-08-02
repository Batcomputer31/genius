class EQSystem:
    # ... (previous code, including __init__, _show_status, process_text_input, run_voice_mode)

    def run_text_mode(self):
        """Run text interaction mode"""
        print("💬 EQ Text Mode Active - Type your messages!")
        print("Type 'exit' to quit, or 'help' for a list of commands.")
        print("You can also type 'file:/path/to/your/file' to process a file!")

        while self.running:
            try:
                user_input = input("\n👤 You: ").strip()
                if user_input.lower() in ("exit", "quit"):
                    print("🌈 Thank you for using EQ System! Goodbye! 🎀")
                    self.running = False
                    break
                elif user_input.lower() == "help":
                    print("\n✨ EQ Commands ✨")
                    print("  hello/hi/hey - Greet the EQ system")
                    print("  status - Check system status")
                    print("  time/date - Get current time or date")
                    print("  file:/path - Process a file (text, pdf, docx, image, video)")
                    print("  upload - Prepare to upload a file")
                    print("  memory/vault - Access memory vault")
                    print("  orbit - Check orbital spike status")
                    print("  remember ... - Store a memory")
                    print("  recall - Recall stored memories")
                    print("  exit/quit - Exit EQ system")
                    continue

                # Process input and get response
                response = self.process_text_input(user_input)
                print(f"🤖 EQ: {response}")

            except KeyboardInterrupt:
                print("\n🌈 EQ System gracefully stopping... 🎀")
                self.running = False
            except Exception as e:
                print(f"🚨 Error: {e}")
                continue

    def start(self, mode="text"):
        """Start the EQ system with specified mode (voice or text)"""
        self.running = True
        if mode == "voice":
            self.run_voice_mode()
        else:
            self.run_text_mode()

# ======== 🚀 MAIN ENTRY POINT ========

if __name__ == "__main__":
    print("""
    🌈 COMPLETE EQ SYSTEM - INDEPENDENT VOICE AI
    No OpenAI, No JSON, No EVA, Just Pure Q Magic!
    Creator: RA | Owner: RAWIRI-H1 | Home: evonation.net
    """)

    # Start the system
    eq = EQSystem(seed_key="77777")
    try:
        if VOICE_AVAILABLE:
            print("🌠 Voice mode is available! Use 'voice' to start with voice, or press Enter for text mode.")
            mode = input("Mode (voice/text): ").strip().lower()
            if mode == "voice":
                eq.start(mode="voice")
            else:
                eq.start(mode="text")
        else:
            print("🌠 Starting in text mode (voice not available).")
            eq.start(mode="text")
    except Exception as e:
        print(f"🚨 Fatal error: {e}")


Sent from Proton Mail Android