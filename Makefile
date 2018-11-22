#
# make tasks for mediasoup-$(WORKER_DIR).
#

# Best effort to get Python 2 executable and also allow custom PYTHON
# environment variable set by the user.
PYTHON ?= $(shell command -v python2 2> /dev/null || echo python)

WORKER_DIR ?=worker-2.4.3

.PHONY: default Release Debug test test-Release test-Debug xcode clean clean-all

default:
ifeq ($(MEDIASOUP_BUILDTYPE),Debug)
	make Debug
else
	make Release
endif

Release:
	cd $(WORKER_DIR) && $(PYTHON) ./scripts/configure.py -R mediasoup-worker
	$(MAKE) BUILDTYPE=Release -C $(WORKER_DIR)/out

Debug:
	cd $(WORKER_DIR) && $(PYTHON) ./scripts/configure.py -R mediasoup-worker
	$(MAKE) BUILDTYPE=Debug -C $(WORKER_DIR)/out

test:
ifeq ($(MEDIASOUP_BUILDTYPE),Debug)
	make test-Debug
else
	make test-Release
endif

test-Release:
	cd $(WORKER_DIR) && $(PYTHON) ./scripts/configure.py -R mediasoup-worker-test
	$(MAKE) BUILDTYPE=Release -C $(WORKER_DIR)/out

test-Debug:
	cd $(WORKER_DIR) && $(PYTHON) ./scripts/configure.py -R mediasoup-worker-test
	$(MAKE) BUILDTYPE=Debug -C $(WORKER_DIR)/out

xcode:
	cd $(WORKER_DIR) && $(PYTHON) ./scripts/configure.py --format=xcode

clean:
	$(RM) -rf $(WORKER_DIR)/out/Release/mediasoup-worker
	$(RM) -rf $(WORKER_DIR)/out/Release/obj.target/mediasoup-worker
	$(RM) -rf $(WORKER_DIR)/out/Release/mediasoup-worker-test
	$(RM) -rf $(WORKER_DIR)/out/Release/obj.target/mediasoup-worker-test
	$(RM) -rf $(WORKER_DIR)/out/Debug/mediasoup-worker
	$(RM) -rf $(WORKER_DIR)/out/Debug/obj.target/mediasoup-worker
	$(RM) -rf $(WORKER_DIR)/out/Debug/mediasoup-worker-test
	$(RM) -rf $(WORKER_DIR)/out/Debug/obj.target/mediasoup-worker-test

clean-all:
	$(RM) -rf $(WORKER_DIR)/out
	$(RM) -rf $(WORKER_DIR)/mediasoup-$(WORKER_DIR).xcodeproj
	$(RM) -rf $(WORKER_DIR)/mediasoup-$(WORKER_DIR)-test.xcodeproj
	$(RM) -rf $(WORKER_DIR)/deps/*/*.xcodeproj
