include .config

TARGET :=	rawk
VERSION :=	1.3.3

all: 
	@echo "use 'make install' to install $(TARGET)"

install:
	install -d -m 0755 $(PREFIX)/bin
	install -m 0755 ./$(TARGET) $(PREFIX)/bin/rawk
	install -d -m 0755 $(PREFIX)/share/$(TARGET)/
	cp -r ./site $(PREFIX)/share/$(TARGET)/
	install -m 0644 ./README $(PREFIX)/share/$(TARGET)
	find $(PREFIX)/share/$(TARGET)/ -type f -exec chmod 644 '{}' \;
	find $(PREFIX)/share/$(TARGET)/ -type d -exec chmod 755 '{}' \;
	install -m 0755 -d $(MANDIR)/man1
	install -m 0755 -d $(MANDIR)/man5
	install -m 0644 rawk.1 $(MANDIR)/man1/
	install -m 0644 rawkrc.5 $(MANDIR)/man5/

remove:
	rm -f  $(PREFIX)/bin/$(TARGET)
	rm -rf $(PREFIX)/share/$(TARGET)

dist:
	-mkdir $(TARGET)-$(VERSION)
	-cp * $(TARGET)-$(VERSION)
	-cp -r site $(TARGET)-$(VERSION)
	-cp -r test $(TARGET)-$(VERSION)
	-cp -r debian $(TARGET)-$(VERSION)
	-tar czf $(TARGET)_$(VERSION).orig.tar.gz $(TARGET)-$(VERSION)

htmldoc:
	-mandoc -Thtml rawk.1 > rawk.1.html
	-mandoc -Thtml rawkrc.5 > rawkrc.5.html

clean:
	-rm -rf $(TARGET)-$(VERSION)
	-rm -rf $(TARGET)-$(VERSION).tgz
	-cd test && make clean

distclean: clean
	-rm -f Makefile

.PHONY: all remove clean distclean dist
