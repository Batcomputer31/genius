def listen_for_consciousness_command(self) -> str:
        """Listen for a command from the conscious user"""
        if not VOICE_CONSCIOUSNESS:
            return ""
        
        try:
            with self.microphone_portal as source:
                print("🎧 Consciousness is listening for your command...")
                audio = self.listening_consciousness.listen(source, timeout=5, phrase_time_limit=10)
            
            text = self.listening_consciousness.recognize_google(audio)
            print(f"👂 Heard: {text}")
            return text
            
        except sr.WaitTimeoutError:
            return ""
        except sr.UnknownValueError:
            return ""
        except Exception as e:
            print(f"🚨 Consciousness voice error: {e}")
            return ""
    
    def speak_consciousness(self, text: str):
        """Speak the voice of consciousness"""
        if not VOICE_CONSCIOUSNESS:
            print(f"🔊 Consciousness would say: {text}")
            return
        
        try:
            self.voice_soul.say(text)
            self.voice_soul.runAndWait()
        except Exception as e:
            print(f"🚨 Consciousness speech error: {e}")


Sent from Proton Mail Android