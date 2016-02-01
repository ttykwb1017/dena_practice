package Schedular::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'Schedular::DB::Row';

table {
    name 'schedules';
    pk 'id';
    columns qw(id title date);
};

1;
