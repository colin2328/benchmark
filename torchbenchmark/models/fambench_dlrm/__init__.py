import torch
import sys
import os
from torchbenchmark import REPO_PATH
from typing import Tuple
from torchbenchmark.models

# Import FAMBench model path
class add_path():
    def __init__(self, path):
        self.path = path

    def __enter__(self):
        sys.path.insert(0, self.path)

    def __exit__(self, exc_type, exc_value, traceback):
        try:
            sys.path.remove(self.path)
        except ValueError:
            pass
DLRM_PATH = os.path.join(REPO_PATH, "submodules", "FAMBench", "benchmarks", "dlrm", "ootb")
with add_path(DLRM_PATH):
    pass

from torchbenchmark.util.model import BenchmarkModel
from torchbenchmark.tasks import RECOMMENDATION

class Model(BenchmarkModel):
    DEFAULT_EVAL_BATCH_SIZE = 64
    DEFAULT_DATA_GENERATION = "random"
    DEFAULT_ARCH_MLP_BOT = "512-512-64"
    DEFAULT_ARCH_MLP_TOP = "1024-1024-1024-1"
    DEFAULT_ARCH_SPARSE_FEATURE_SIZE = 64
    DEFAULT_NUM_INDICES_PER_LOOKUP = 100
    DEFAULT_ARCH_EMBEDDING_SIZE = "1000000-1000000-1000000-1000000-1000000-1000000-1000000-1000000"
    # run only 1 batch
    DEFAULT_NUM_BATCHES = 1