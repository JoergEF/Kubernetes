new:
	vagrant up

fresh: clean
	vagrant up

clean:
	vagrant destroy -f
	rm -rf .vagrant
	rm cephDisk*
	rm roles/iad*
