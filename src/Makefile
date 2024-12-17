SUBDIRS?=$(foreach SUBDIR,cinnamon gtk2 gtk3 libadwaita metacity thumbnail xfwm4,assets-renderer/$(SUBDIR)) sass
THEMES_DIR=../themes

include Makefile.inc

.PHONY: build $(SUBDIRS) clean

build: $(SUBDIRS)
	$(MAKE) -C templates build
	# Remove variants that are not valid
	find $(THEMES_DIR) -name "Flat-Remix-GTK-$(UNWANTED_VARIANTS)" -or -name "Flat-Remix-LibAdwaita-$(UNWANTED_VARIANTS)" -print0 | xargs -0 rm -rf
	# Add Solid themes
	find $(THEMES_DIR) -name "Flat-Remix-GTK-*" -or -name "Flat-Remix-LibAdwaita-*" \
		-exec cp -a {} "$${THEMES_DIR}/$${0}-Solid" \; \
		-exec find "$${THEMES_DIR}/$${0}-Solid" -name "*-solid.css" \
			-exec sh -c 'mv $$1 $$(echo $$1 | sed "s/-solid//")' _ {} \; \; \
		-exec find "$${THEMES_DIR}/$${0}-Solid" -name "*-solid.css" -delete \;

$(SUBDIRS):
	$(MAKE) -C $@ build

clean:
	$(foreach SUBDIR,$(SUBDIRS),$(MAKE) -C $(SUBDIR) clean &&) true
