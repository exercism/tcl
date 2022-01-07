namespace eval proteinTranslation {
    namespace export proteins

    variable translation {
        UGC Cysteine          UCA Serine
        UGU Cysteine          UCC Serine
        UUA Leucine           UCG Serine
        UUG Leucine           UCU Serine
        AUG Methionine        UGG Tryptophan
        UUC Phenylalanine     UAC Tyrosine
        UUU Phenylalanine     UAU Tyrosine

        UAA STOP   UAG STOP   UGA STOP
    }

    proc proteins {strand} {
        variable translation
        set proteins {}
        while {$strand ne ""} {
            set codon  [string range $strand 0 2]
            set strand [string range $strand 3 end]
            if {![dict exists $translation $codon]} {
                error "Invalid codon"
            }
            set protein [dict get $translation $codon]
            if {$protein eq "STOP"} {
                break
            }
            lappend proteins $protein
        }
        return $proteins
    }
}

namespace import proteinTranslation::proteins
