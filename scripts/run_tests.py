"""Run connector and bundled Librarian tests against this checkout."""
from pathlib import Path
import sys
import unittest

root = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(root / 'librarian'))
suite = unittest.TestSuite([
    unittest.TestLoader().discover(str(root / 'tests')),
    unittest.TestLoader().discover(str(root / 'librarian' / 'tests')),
])
result = unittest.TextTestRunner(verbosity=2).run(suite)
raise SystemExit(0 if result.wasSuccessful() else 1)
