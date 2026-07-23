#!/usr/bin/env tclsh
# generated: 2026-07-23T11:59:45Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "rail-fence-cipher.tcl"


test rail-fence-cipher-1 "encode with two rails" -body {
    railFenceCipher encode "XOXOXOXOXOXOXOXOXO" 2
} -returnCodes ok -result "XXXXXXXXXOOOOOOOOO"

skip rail-fence-cipher-2
test rail-fence-cipher-2 "encode with three rails" -body {
    railFenceCipher encode "WEAREDISCOVEREDFLEEATONCE" 3
} -returnCodes ok -result "WECRLTEERDSOEEFEAOCAIVDEN"

skip rail-fence-cipher-3
test rail-fence-cipher-3 "encode with ending in the middle" -body {
    railFenceCipher encode "EXERCISES" 4
} -returnCodes ok -result "ESXIEECSR"

skip rail-fence-cipher-4
test rail-fence-cipher-4 "decode with three rails" -body {
    railFenceCipher decode "TEITELHDVLSNHDTISEIIEA" 3
} -returnCodes ok -result "THEDEVILISINTHEDETAILS"

skip rail-fence-cipher-5
test rail-fence-cipher-5 "decode with five rails" -body {
    railFenceCipher decode "EIEXMSMESAORIWSCE" 5
} -returnCodes ok -result "EXERCISMISAWESOME"

skip rail-fence-cipher-6
test rail-fence-cipher-6 "decode with six rails" -body {
    railFenceCipher decode "133714114238148966225439541018335470986172518171757571896261" 6
} -returnCodes ok -result "112358132134558914423337761098715972584418167651094617711286"


cleanupTests
