curl -XPUT 'localhost:9200/lookupindex/_settings' -d '{
    "index": {
        "analysis": {
            "analyzer": {
                "custom_standard_analyzer": {
                    "type": "custom",
                    "tokenizer": "whitespace",
                    "filter": [
                        "lowercase",
                        "asciifolding",
                        "customstopwords"
                    ]
                },
                "phonetic_analyzer": {
                    "type": "custom",
                    "tokenizer": "standard",
                    "filter": [
                        "lowercase",
                        "asciifolding",
                        "phoneticstopwords"
                    ]
                }
            },
            "filter": {
                "customstopwords": {
                    "type": "stop",
                    "stopwords": [
                        "+",
                        ".",
                        " ",
                        "ca",
                        "fl",
                        "bc",
                        "b.c",
                        "b.c.e",
                        "bce",
                        "act.c.",
                        "act",
                        "style",
                        "style of",
                        "attr.",
                        "attr",
                        "manner of",
                        "manner",
                        "circle of",
                        "circle",
                        "after",
                        "near",
                        "copy",
                        "copy after",
                        "imitator",
                        "school, copy",
                        "studio",
                        "studio of",
                        "Italian school",
                        "workshop of",
                        "workshop",
                        "16th",
                        "or",
                        "17th c.",
                        "late follower",
                        "follower of",
                        "follower",
                        "attributed",
                        "near",
                        "copy after painting",
                        "by or after",
                        "fake",
                        "and school",
                        "workshop-copy",
                        "counterproof",
                        "copy after drawing",
                        "copy of",
                        "school of",
                        "called",
                        "copy IBS",
                        "German School",
                        "placed with",
                        "attribution"
                    ]
                },
                "phoneticstopwords": {
                    "type": "stop",
                    "stopwords": [
                        "+",
                        ",",
                        "-",
                        ".",
                        "ca",
                        "fl",
                        "bc",
                        "b.c",
                        "b.c.e",
                        "bce",
                        "act.c.",
                        "act",
                        "style",
                        "style of",
                        "attr.",
                        "attr",
                        "manner of",
                        "manner",
                        "circle of",
                        "circle",
                        "after",
                        "near",
                        "copy",
                        "copy after",
                        "imitator",
                        "school, copy",
                        "studio",
                        "studio of",
                        "Italian school",
                        "workshop of",
                        "workshop",
                        "16th",
                        "or",
                        "17th c.",
                        "late follower",
                        "follower of",
                        "follower",
                        "attributed",
                        "near",
                        "copy after painting",
                        "by or after",
                        "fake",
                        "and school",
                        "workshop-copy",
                        "counterproof",
                        "copy after drawing",
                        "copy of",
                        "school of",
                        "called",
                        "copy IBS",
                        "German School",
                        "placed with",
                        "attribution"
                    ]
                }
            }
        }
    }
}
'  
