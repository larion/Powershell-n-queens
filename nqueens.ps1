#型
param([int]$n=8)
function nqueens{
    param([int]$n) #chesssboard size
    $solutionset=@()
    $position=@()
    $depth = 0
    for($i=0;$i -ne $n;$i++){
        $position+=0
    }
    while($depth -gt -1){
        while($depth -gt -1 -and $depth -lt $n){
            for($i = $position[$depth]+1; $i -le $n; $i++){
               $position[$depth]=$i
               if(checkifok $position $depth){ #let's go on then
                    $depth+=1
                    break
               }
               else{         #let's try the next square
                    continue
               }
            }
            if($i -eq $n+1){ #akkor bektrekk
                $position[$depth]=0
                $depth-=1
            }
        }
        if($depth -gt -1){ #We have a solution! :)
            $solutionset+=,@($position)
            $depth-- #$depth=$n
            $position[$depth]=0 #clean up the last column
            $depth-- #backtrack
        }
    }
    return $solutionset
} 

function checkifok{
param($pos, $dp)
#check position assuming that everything is ok in the first $dp-1 rows
    $newpos = $pos[$dp]
    if($dp -ne 0){ #check columns
        if($pos[0..($dp-1)] -contains $newpos){
            return 0
         }
     }
    for($i=1; $i -le $dp; $i++){ #check diagonals
        if($pos[$dp-$i] -eq $newpos - $i -or $pos[$dp-$i] -eq $newpos + $i){
            return 0
        }
    }       
    return 1
}

$solutions = nqueens $n;
foreach($pos in $solutions){
    for($i = 0; $i -ne $n; $i++){
        Write-Host;
        for($i2 = 1; $i2 -le $n; $i2++){
            if($pos[$i] -eq $i2){
                if( ($i+$i2)%2){
                    Write-Host -NoNewline -BackgroundColor "white" -ForegroundColor "black" "II"
                }
                else{
                    Write-Host -NoNewline -BackgroundColor "black" -ForegroundColor "white" "II"
                }
            }
            else{
                if( ($i+$i2)%2){
                    Write-Host -NoNewline -BackgroundColor "white" "  "
                }
                else{
                    Write-Host -NoNewline -BackgroundColor "black" "  "
                }
            }
        }
    }
    Write-Host
}
