#!/bin/bash
# set -x
artexchange='/mnt/storage2/s/artexchange-root/artexchange'
artexchange_back='/mnt/storage2/s/artexchange-root/artexchange-back'

days_move='14'
days_delete='30'

mkdir --parents ${artexchange}
mkdir --parents ${artexchange_back}

date_today=`date --date today +%Y-%m-%d`
date_yesterday=`date --date yesterday +%Y-%m-%d`
date_ereyesterday=`date --date '-2 day' +%Y-%m-%d`

#date_today='2015-04-04'
#date_yesterday='2015-04-03'
#date_ereyesterday='2015-04-02'

# удаляем вчерашнний сегодня-симлинк и вчера-симлинк
#unlink ${artexchange}/00-сегодня-${date_yesterday}
#unlink ${artexchange}/01-вчера-${date_ereyesterday}

# удаляем все симлинки / альтернативный вариант
find ${artexchange} -maxdepth 1 -type l -print0 | xargs -0 --replace=filename rm -v filename


# создаем сегодняшнее "сегодня"
mkdir --parents ${artexchange}/${date_today}/Дизайнеры
mkdir --parents ${artexchange}/${date_today}/Менеджеры

# создаем сегодняшний сегодня-симлинк и вчера-симлинк
ln --symbolic --no-dereference ${artexchange}/${date_today} ${artexchange}/00-сегодня-${date_today}
ln --symbolic --no-dereference ${artexchange}/${date_yesterday} ${artexchange}/01-вчера-${date_yesterday}

# переносим в архив
cd ${artexchange}
find -maxdepth 1 -mtime +${days_move} -print0 | xargs -0 --replace=filename mv filename ${artexchange_back}/filename-${date_today}

# чистим архив
cd ${artexchange_back}
find ${artexchange_back} -maxdepth 1 -mtime +${days_delete} -print0 | xargs -0 --replace=filename rm -rfv filename
