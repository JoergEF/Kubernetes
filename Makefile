new:
	vagrant up

fresh: clean
	vagrant up

clean:
	vagrant destroy -f
	[ -d .vagrant ] && rm -rf .vagrant
	[ -e roles\iad*-join-command ] && rm roles/iad*
