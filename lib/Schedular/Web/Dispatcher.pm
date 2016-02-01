package Schedular::Web::Dispatcher;
# $BJ8K!%A%'%C%/(B
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use Time::Piece;
# my $xx; $B%9%+%iJQ?t$NDj5A(B
# my @xx; $BG[NsJQ?t$NDj5A(B
# $i++ i$B$r%$%s%/%j%a%s%H(B
get '/' => sub {
    my ($c) = @_;
    my @schedules = $c->db->search('schedules'); # (1)
    for my $schedule (@schedules) {
            print STDERR $schedule->title . "\n";
                }
   
   return $c->render('index.tx', { schedules => \@schedules });
};

post '/post' =>sub {
    my ($c) = @_;

    my $title = $c->req->parameters->{title}; 
    my $date  = $c->req->parameters->{date};

    my $date_epoch = Time::Piece->strptime($date, '%Y/%m/%d')->epoch;

    $c->db->insert(schedules => { 
        title => $title,          
        date  => $date_epoch,     
    });                           
            
    return $c->redirect('/');
 };    

#get '/user' => sub{
#    my ($c) = @_;
#    my $namae = "Tetsuya Kawabe";
#    my $nenrei = "23";
#    my $syozoku = "Mech. Eng. Osaka Univ.";
#    my $syumi = "cycling, watching tennis games";
#
#    return $c->render('user.tx', {
#        namae => $namae,
#        nenrei => $nenrei,
#        syozoku => $syozoku,
#        syumi => $syumi,
#    });
 
 
#};

1;
