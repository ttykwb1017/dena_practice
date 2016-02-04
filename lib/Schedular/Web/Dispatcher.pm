package Schedular::Web::Dispatcher;
# 文法チェック
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use Time::Piece;
# my $xx; スカラ変数の定義
# my @xx; 配列変数の定義
# $i++ iをインクリメント
get '/' => sub {
    my ($c) = @_;
    my $order = $c->req->parameters->{order} // "";
    my @schedules;
    if ($order eq 'reverse') {
        @schedules = $c->db->search('schedules', {}, { order_by => 'date ASC'});
      }
    else{
       @schedules = $c->db->search('schedules', {}, { order_by => 'date DESC'});
    }

    my $kyou_epoch_detail = localtime;
    my $kyou_epoch = $kyou_epoch_detail->strftime('%Y/%m/%d');
#    print STDERR $order . "\n";
  
   return $c->render('index.tx', { schedules => \@schedules ,kyou_epoch => $kyou_epoch} );
};

post '/post' =>sub {
    my ($c) = @_;

    my $title = $c->req->parameters->{title}; 
    my $date  = $c->req->parameters->{date};
    my $date_epoch = Time::Piece->strptime($date, '%Y/%m/%d')->epoch;

    
#    if ($date_epoch eq $kyou_epoch){
#       $date_epoch = <p style ='color:red'>$date_epoch</p>;
#    }


    $c->db->insert(schedules => { 
        title => $title,          
        date  => $date_epoch,     
    });                           
            
    return $c->redirect('/');
 };    
      
post '/schedules/:id/delete' => sub {
    my ($c, $args) = @_;
    my $id = $args->{id};
 
    $c->db->delete('schedules' => { id => $id });
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
