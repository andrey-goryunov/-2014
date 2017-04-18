#!/bin/bash
#set -x

#все они здесь
rsync -avch --files-from=vault-list.txt --log-file=log-rsync.txt --partial --force /mnt/nfs-storage/ all-vault/

#удаляем
while read line; do
rm -v /mnt/nfs-storage/"${line}" >> log-rm.txt
done < vault-list.txt
# 4 раза подряд надо это сделать, в среднем :)
# ----

# затем найдем пустые каталоги
find /mnt/nfs-storage/exchange -depth -type d -empty > empty-dir-list4.txt

# и удалим их
while read line; do
rmdir -v "${line}" >> log-rm-dir4.txt
done < empty-dir-list4.txt
