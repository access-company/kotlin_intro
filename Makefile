
all: $(CURDIR)/src/node_modules
	cd $(CURDIR)/src &&     \
	gitbook build &&        \
	rm -r $(CURDIR)/docs && \
	mv $(CURDIR)/src/_book $(CURDIR)/docs

$(CURDIR)/src/node_modules:
	cd $(CURDIR)/src && \
	gitbook install

