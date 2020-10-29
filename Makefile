#!make

install-myriad:
	echo "SUBSYSTEM==\"usb\", ATTRS{idProduct}==\"2150\", ATTRS{idVendor}==\"03e7\", GROUP=\"users\", MODE=\"0666\", ENV{ID_MM_DEVICE_IGNORE}=\"1\"" > 97-myriad-usbboot.rules
	echo "SUBSYSTEM==\"usb\", ATTRS{idProduct}==\"2485\", ATTRS{idVendor}==\"03e7\", GROUP=\"users\", MODE=\"0666\", ENV{ID_MM_DEVICE_IGNORE}=\"1\"" >> 97-myriad-usbboot.rules
	echo "SUBSYSTEM==\"usb\", ATTRS{idProduct}==\"f63b\", ATTRS{idVendor}==\"03e7\", GROUP=\"users\", MODE=\"0666\", ENV{ID_MM_DEVICE_IGNORE}=\"1\"" >> 97-myriad-usbboot.rules

	sudo mv 97-myriad-usbboot.rules /etc/udev/rules.d/97-myriad-usbboot.rules
	sudo udevadm control --reload-rules
	sudo udevadm trigger
	sudo ldconfig
	echo "Udev rules have been successfully installed."

