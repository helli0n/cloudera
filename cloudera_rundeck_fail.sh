#!/usr/bin/perl
# use module
use XML::Simple;
use JSON;
use Data::Dumper;
use strict;
use warnings;
use XML::LibXML;
use File::Path;


my $filed = "333333";
unlink $filed;
if (-e $filed)
{
#print "File has NOT been deleted!";
}
else
{
#print "File has been deleted successfully";
}

my $url="http://rundeck:4440/api/13/history?project=cluster-jobs&statFilter=";
my $rdate="";
system("/usr/bin/curl -s --header 'X-Rundeck-Auth-Token:czIfT77GonQRM5tdtC4OmhkVTP8bEtCo' -H 'Content-Type=application/json' 'http://rundeck:4440/api/13/history?project=cluster-jobs&statFilter=fail&recentFilter=1m' >> 333333");
my $xmlSimple = new XML::Simple;

# read XML file
my $filename = "333333";
my $parser = XML::LibXML->new();
my $xmldoc = $parser->parse_file($filename);

my @names = ('{"data":[');
for my $sample ($xmldoc->findnodes('/events/event')) {
    for my $property ($sample->findnodes('./*')) {
            if ( $property->nodeName() eq 'title') {
            my $add = '{"{#JOBNAME}":"'.$property->textContent().'"';
            my $property2 = $property->getAttribute('id');
            push @names, $add;
            }
            if ($property->nodeName() eq 'job') {
            my $add = ',"{#JOBID}":"'.$property->getAttribute('id').'"';
            push @names, $add;
            }
            if ($property->nodeName() eq 'execution') {
            my $add = ',"{#EXID}":"'.$property->getAttribute('id').'"},';
            push @names, $add;
            }
                }
                    }
#            print @names;
my $scal;
$scal .= $_ foreach @names;
            my $scalar = substr($scal, 0, -1);
        print $scalar."]}";
