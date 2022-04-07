
TMP_COMMIT_MSG_FILE=/tmp/commit_message.txt

all: $(CURDIR)/src/node_modules

$(CURDIR)/src/node_modules:
	cd $(CURDIR)/src && \
	npx honkit build --reload && \
	cd .. && \
	rm -rf $(CURDIR)/docs && \
	mv $(CURDIR)/src/_book $(CURDIR)/docs
	cp $(CURDIR)/src/*.js $(CURDIR)/docs

commit: gen_commit_msg
	git add $(CURDIR)/docs
	git commit -F $(TMP_COMMIT_MSG_FILE)

.PHONY:
gen_commit_msg:
	$(CURDIR)/commit_message.sh > $(TMP_COMMIT_MSG_FILE)
