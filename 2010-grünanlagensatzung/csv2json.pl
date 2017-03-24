#!/usr/bin/env perl
use lib "lib";
use GKtoLatLong;

open (FILE1, 'Anhang zur Grünflächensatzung.csv');
$first = 1;
while (<FILE1>) {
    ($lfdnr, $name, $a, $b) = split(';', $_);
    if ($a>0 && $b>0) {
        convGKtoLatLong ($a, $b);
        if ($first == 1) {
            print "{ \"type\": \"FeatureCollection\",\n" .
                  "  \"features\": [\n";
        } else {
            print "    },\n";
        }
        print "    { \"type\": \"Feature\",\n" .
              "      \"geometry\": {\n" .
              "        \"type\": \"Point\", \"coordinates\": [" . $b . ', ' . $a . "]},\n" .
              "        \"properties\": {\"name\": \"" . $name . "\"}\n";
        $first = 0;
    }
}

print "    }\n".
      "  ]\n" .
      "}";
