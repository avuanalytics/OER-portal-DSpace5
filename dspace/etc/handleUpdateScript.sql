UPDATE handle SET handle = '123456789/86' WHERE handle = '123456789/1';
UPDATE handle SET handle = '123456789/87' WHERE handle = '123456789/2';
UPDATE handle SET handle = '123456789/88' WHERE handle = '123456789/3';
UPDATE handle SET handle = '123456789/91' WHERE handle = '123456789/4';
UPDATE handle SET handle = '123456789/96' WHERE handle = '123456789/5';
UPDATE handle SET handle = '123456789/92' WHERE handle = '123456789/6';
UPDATE handle SET handle = '123456789/97' WHERE handle = '123456789/7';
UPDATE handle SET handle = '123456789/93' WHERE handle = '123456789/8';
UPDATE handle SET handle = '123456789/98' WHERE handle = '123456789/9';
UPDATE handle SET handle = '123456789/261' WHERE handle = '123456789/10';
UPDATE handle SET handle = '123456789/264' WHERE handle = '123456789/11';
UPDATE handle SET handle = '123456789/262' WHERE handle = '123456789/12';
UPDATE handle SET handle = '123456789/94' WHERE handle = '123456789/13';
UPDATE handle SET handle = '123456789/99' WHERE handle = '123456789/14';
UPDATE handle SET handle = '123456789/95' WHERE handle = '123456789/15';
UPDATE handle SET handle = '123456789/100' WHERE handle = '123456789/16';
UPDATE handle SET handle = '123456789/113' WHERE handle = '123456789/17';
UPDATE handle SET handle = '123456789/114' WHERE handle = '123456789/18';
UPDATE handle SET handle = '123456789/89' WHERE handle = '123456789/19';
UPDATE handle SET handle = '123456789/101' WHERE handle = '123456789/20';
UPDATE handle SET handle = '123456789/107' WHERE handle = '123456789/21';
UPDATE handle SET handle = '123456789/102' WHERE handle = '123456789/22';
UPDATE handle SET handle = '123456789/108' WHERE handle = '123456789/23';
UPDATE handle SET handle = '123456789/103' WHERE handle = '123456789/24';
UPDATE handle SET handle = '123456789/109' WHERE handle = '123456789/25';
UPDATE handle SET handle = '123456789/122' WHERE handle = '123456789/26';
UPDATE handle SET handle = '123456789/123' WHERE handle = '123456789/27';
UPDATE handle SET handle = '123456789/104' WHERE handle = '123456789/28';
UPDATE handle SET handle = '123456789/110' WHERE handle = '123456789/29';
UPDATE handle SET handle = '123456789/105' WHERE handle = '123456789/30';
UPDATE handle SET handle = '123456789/111' WHERE handle = '123456789/31';
UPDATE handle SET handle = '123456789/106' WHERE handle = '123456789/32';
UPDATE handle SET handle = '123456789/112' WHERE handle = '123456789/33';
UPDATE handle SET handle = '123456789/90' WHERE handle = '123456789/34';
UPDATE handle SET handle = '123456789/115' WHERE handle = '123456789/35';
UPDATE handle SET handle = '123456789/124' WHERE handle = '123456789/36';
UPDATE handle SET handle = '123456789/117' WHERE handle = '123456789/37';
UPDATE handle SET handle = '123456789/125' WHERE handle = '123456789/38';
UPDATE handle SET handle = '123456789/120' WHERE handle = '123456789/39';
UPDATE handle SET handle = '123456789/126' WHERE handle = '123456789/40';
UPDATE handle SET handle = '123456789/119' WHERE handle = '123456789/41';
UPDATE handle SET handle = '123456789/127' WHERE handle = '123456789/42';
UPDATE handle SET handle = '123456789/118' WHERE handle = '123456789/43';
UPDATE handle SET handle = '123456789/128' WHERE handle = '123456789/44';
UPDATE handle SET handle = '123456789/121' WHERE handle = '123456789/45';
UPDATE handle SET handle = '123456789/129' WHERE handle = '123456789/46';
UPDATE handle SET handle = '123456789/116' WHERE handle = '123456789/47';
UPDATE handle SET handle = '123456789/130' WHERE handle = '123456789/48';

SELECT setval('handle_seq',
              CAST (
                    max(
                        to_number(regexp_replace(handle, '.*/', ''), '999999999999')
                       )
                    AS BIGINT)
             )
    FROM handle
    WHERE handle SIMILAR TO '%/[0123456789]*';