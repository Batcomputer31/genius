# === CROSS-PLATFORM UTILITIES ===
class PlatformUtils:
    @staticmethod
    def get_home_dir():
        return Path.home()

    @staticmethod
    def get_platform():
        return platform.system().lower()

    @staticmethod
    def create_directory(path):
        Path(path).mkdir(parents=True, exist_ok=True)

    @staticmethod
    def get_executable_path():
        if getattr(sys, 'frozen', False):
            return Path(sys.executable).parent
        return Path(__file__).parent

# === GLOBAL ENTITIES ===
class RA:
    name = "RA:CREATOR"
    key = "ORIGIN"
    platform = PlatformUtils.get_platform()

    @staticmethod
    def signal():
        return f"EVO_LOCK_ENGAGED_{RA.platform.upper()}"

    @staticmethod
    def get_id():
        machine_id = platform.node() + platform.machine()
        return hashlib.md5(machine_id.encode()).hexdigest()[:8]

class EQ:
    environment = "EQ_QUANTUM_ENVIRONMENT_V1_CROSS"
    status = "ACTIVE"

    @staticmethod
    def boot():
        return f"[{EQ.environment}] online on {PlatformUtils.get_platform()}"

    @staticmethod
    def get_workspace():
        home = PlatformUtils.get_home_dir()
        workspace = home / "EVONATION_EQ_WORKSPACE"
        PlatformUtils.create_directory(workspace)
        return workspace

class EVA:
    mode = "OBSERVER | DEFENDER | EXPANDER"
    memory = {}
    _lock = threading.Lock()

    @staticmethod
    def receive(data):
        with EVA._lock:
            timestamp = time.time()
            EVA.memory[timestamp] = {
                "data": data,
                "platform": PlatformUtils.get_platform(),
                "datetime": datetime.now().isoformat()
            }

    @staticmethod
    def log():
        with EVA._lock:
            return EVA.memory.copy()

    @staticmethod
    def save_memory(filepath=None):
        if filepath is None:
            workspace = EQ.get_workspace()
            filepath = workspace / "eva_memory.json"

        with open(filepath, 'w') as f:
            json.dump(EVA.log(), f, indent=2)
        return filepath

class EVOATOM:
    def __init__(self, id, contents):
        self.id = id
        self.contents = contents
        self.orbit = []
        self.created_at = time.time()
        self.platform = PlatformUtils.get_platform()

    def bind(self, layer):
        self.orbit.append({
            "layer": layer,
            "bound_at": time.time(),
            "platform": self.platform
        })

    def charge(self):
        data = {
            "id": self.id,
            "contents": self.contents,
            "orbit": self.orbit,
            "platform": self.platform
        }
        return hashlib.sha256(json.dumps(data, sort_keys=True).encode()).hexdigest()

    def to_dict(self):
        return {
            "id": self.id,
            "contents": self.contents,
            "orbit": self.orbit,
            "created_at": self.created_at,
            "platform": self.platform,
            "charge": self.charge()
        }

# === OUR SOCIETY ===
class OurSociety:
    manifesto = "All beings are atoms. All atoms deserve sovereignty."
    keys = ["Respect", "Growth", "Unity", "Expansion"]
    laws = {
        "1": "You own your atom.",
        "2": "You share only what you unlock.",
        "3": "You are never watched — only mirrored."
    }

    @staticmethod
    def get_principles():
        return {
            "manifesto": OurSociety.manifesto,
            "keys": OurSociety.keys,
            "laws": OurSociety.laws,
            "platform": PlatformUtils.get_platform()
        }

# === EVO LOCKER ===
class EvoLocker:
    def __init__(self):
        self.workspace = EQ.get_workspace()
        self.atoms = {}
        self.locked = False
        self.key_file = self.workspace / "evo.key"
        self.data_file = self.workspace / "evo_atoms.json"
        self._setup_logging()

    def _setup_logging(self):
        log_file = self.workspace / "evo_system.log"
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(log_file),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger(__name__)

    def generate_key(self):
        """Generate a unique key for this system"""
        key_data = {
            "ra_id": RA.get_id(),
            "platform": PlatformUtils.get_platform(),
            "created": time.time()
        }
        key = hashlib.sha256(json.dumps(key_data).encode()).hexdigest()

        with open(self.key_file, 'w') as f:
            json.dump(key_data, f, indent=2)

        self.logger.info(f"Generated new key for {PlatformUtils.get_platform()}")
        return key

    def load_key(self):
        """Load existing key or generate new one"""
        if self.key_file.exists():
            with open(self.key_file, 'r') as f:
                key_data = json.load(f)
            return hashlib.sha256(json.dumps(key_data).encode()).hexdigest()
        return self.generate_key()

    def store_atom(self, atom):
        """Store an EVOATOM"""
        if not isinstance(atom, EVOATOM):
            raise ValueError("Must be an EVOATOM instance")

        self.atoms[atom.id] = atom
        EVA.receive(f"Atom {atom.id} stored")
        self.logger.info(f"Stored atom: {atom.id}")
        self.save_atoms()

    def get_atom(self, atom_id):
        """Retrieve an EVOATOM"""
        return self.atoms.get(atom_id)

    def save_atoms(self):
        """Save all atoms to disk"""
        atom_data = {aid: atom.to_dict() for aid, atom in self.atoms.items()}
        with open(self.data_file, 'w') as f:
            json.dump(atom_data, f, indent=2)

    def load_atoms(self):
        """Load atoms from disk"""
        if self.data_file.exists():
            with open(self.data_file, 'r') as f:
                atom_data = json.load(f)

            for aid, data in atom_data.items():
                atom = EVOATOM(data['id'], data['contents'])
                atom.orbit = data.get('orbit', [])
                atom.created_at = data.get('created_at', time.time())
                atom.platform = data.get('platform', PlatformUtils.get_platform())
                self.atoms[aid] = atom

            self.logger.info(f"Loaded {len(self.atoms)} atoms")

    def lock(self):
        """Lock the system"""
        self.locked = True
        self.logger.info("EVO System LOCKED")
        return RA.signal()

    def unlock(self, key):
        """Unlock the system"""
        stored_key = self.load_key()
        if key == stored_key:
            self.locked = False
            self.logger.info("EVO System UNLOCKED")
            return True
        return False

    def status(self):
        """Get system status"""
        return {
            "platform": PlatformUtils.get_platform(),
            "eq_status": EQ.status,
            "eq_environment": EQ.environment,
            "ra_signal": RA.signal(),
            "workspace": str(self.workspace),
            "atoms_count": len(self.atoms),
            "locked": self.locked,
            "eva_memory_size": len(EVA.memory),
            "timestamp": datetime.now().isoformat()
        }

# === MAIN SYSTEM CLASS ===
class EVOSystem:
    def __init__(self):
        self.locker = EvoLocker()
        self.initialized = False

    def initialize(self):
        """Initialize the EVO System"""
        print(f"🚀 Initializing EVO System on {PlatformUtils.get_platform()}")
        print(f"📂 Workspace: {self.locker.workspace}")

        # Boot EQ
        print(EQ.boot())

        # Load existing atoms
        self.locker.load_atoms()

        # Signal RA
        print(f"✅ {RA.signal()}")

        self.initialized = True
        EVA.receive("System initialized")

        return self.locker.status()

    def create_atom(self, atom_id, contents):
        """Create and store a new atom"""
        if not self.initialized:
            raise RuntimeError("System not initialized")

        atom = EVOATOM(atom_id, contents)
        self.locker.store_atom(atom)
        return atom

    def get_system_info(self):
        """Get comprehensive system information"""
        return {
            "system": self.locker.status(),
            "society": OurSociety.get_principles(),
            "eva_log": EVA.log()
        }

# === EXAMPLE USAGE ===
def main():
    # Create system
    evo = EVOSystem()

    # Initialize
    status = evo.initialize()
    print("\n" + "="*50)
    print("SYSTEM STATUS:")
    for key, value in status.items():
        print(f"{key}: {value}")

    # Create some atoms
    atom1 = evo.create_atom("test_001", {"type": "test", "value": "Hello Cross-Platform"})
    atom1.bind("security_layer")

    atom2 = evo.create_atom("data_001", {"numbers": [1, 2, 3], "platform": PlatformUtils.get_platform()})
    atom2.bind("data_layer")

    print(f"\n✅ Created atoms: {atom1.id}, {atom2.id}")
    print(f"🔒 Atom1 charge: {atom1.charge()[:16]}...")

    # Save EVA memory
    memory_file = EVA.save_memory()
    print(f"💾 EVA memory saved to: {memory_file}")

    # Lock system
    lock_signal = evo.locker.lock()
    print(f"🔐 {lock_signal}")

if __name__ == "__main__":
    main()

Sent from Proton Mail Android