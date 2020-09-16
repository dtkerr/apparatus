all:
	@echo 'choose a specific target'
	@exit 1

.PHONY: build
build:
	$(MAKE) -C _terraform

.PHONY: weaver.oefd.net
weaver.oefd.net:
	sudo salt-call --file-root _states --pillar-root _pillar --local state.apply

.PHONY: beagle.oefd.net
beagle.oefd.net:
	salt-ssh --config-dir=saltcfg "beagle.oefd.net" state.apply
