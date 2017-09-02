DOCKER = sudo -E docker
STACK = mybox
FQDN = lo
CACHE = .cache


YAML_FILES := $(wildcard services/*.yml)
.PHONY: all deploy clean

all: deploy

deploy: $(CACHE)/deployed
$(CACHE)/deployed: $(CACHE) $(YAML_FILES)
	@$(foreach f, $?, \
    FQDN=$(FQDN) $(DOCKER) stack deploy -c "$f" $(STACK);)
	touch $@

$(CACHE):
	@mkdir -p $@

clean:
	rm -r $(CACHE)

