
TMP_COMMIT_MSG_FILE=/tmp/commit_message.txt

all: $(CURDIR)/src/node_modules
	cd $(CURDIR)/src &&     \
	gitbook build &&        \
	rm -r $(CURDIR)/docs && \
	mv $(CURDIR)/src/_book $(CURDIR)/docs

$(CURDIR)/src/node_modules:
	cd $(CURDIR)/src && \
	gitbook install

commit: gen_commit_msg
	git add $(CURDIR)/docs
	git commit -F $(TMP_COMMIT_MSG_FILE)

.PHONY:
gen_commit_msg:
	$(CURDIR)/commit_message.sh > $(TMP_COMMIT_MSG_FILE)
