new:
	vagrant up

fresh: clean
	vagrant up

clean:
	vagrant destroy -f
	rm -rf .vagrant
	[ -x cephDisk-1.vdi ] && rm cephDisk*
	[ -x roles\iad*-join-command ] && rm roles/iad*
