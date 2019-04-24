program counterHp;
uses crt;
const nmax = 1347;
type 
    handphone = record
        stok : integer;
        merk : string;
        harga : longint;
        end;
type tabHp = array [1..nmax] of handphone;

var 
    merk, smerk : string;
    x : char;
    tabelHp : tabHp;
    idx, stk, pilih, m : integer;

    function binarySearch(t : tabHp; n : integer ; key : longint) : integer;
    var
        top, btm, mid : integer;
        found : boolean;
    begin
        top := n;
        btm:=1;
        found:=false;
        while (top >= btm) and (found = false) do 
        begin
            mid:= ( top + btm )div 2;
            if (key < t[mid].harga) then 
                top := mid -1
            else if (key > t[mid].harga ) then 
                btm := mid + 1
            else 
                found := true;
        end;
        if (found = true ) then 
            binarySearch := mid
        else 
            binarySearch := -1;
    end;

    procedure hapusProduk(var t : tabHp;var n : integer ; idx : integer);
    {I.S terdefinisi tabel t sebanyak n
    F.S data yang dicari terhapus}
    var
        i : integer;
        found : boolean;
    begin
        i:= idx;
        while (i <= n) do 
        begin
            t[i]:=t[i+1];
            i:=i+1;
        end;
        n:= n - 1;
    end;

    function cariProduk(t : tabHp; dataMerk : string; n : integer) : integer;
    {mengembalikan indeks dari data Hp dengan merk = dataMerk
    dan -1 jika tidak ada(sequential search)}
    var
        i : integer;
        found : boolean;
    begin
        i:= 1;
        while (i <= n) and (t[i].merk <> dataMerk) do 
        begin
            i:=i+1;
        end;
        if (t[i].merk = dataMerk) then 
            cariProduk := i
        else 
            cariProduk := -1;
    end;

    procedure printProduk(t : tabHp);
    {I.S terdefinisi t berisi data produk
    F.S menampilkan produk yang di update}
    var
        i : integer;
    begin
        i := 1;
        while (i <= length(t[i].merk)) do
        begin
            writeln('Merk         : ',t[i].merk);
            writeln('Stok         : ',t[i].stok);
            writeln('Harga satuan : ',t[i].harga);
            i := i + 1;
        end;
    end;

    procedure bubbleSort6(var t : tabHp; n : integer);
    {I.S terdefinisi tabel t
    F.S tabel t terurut}
    var
        pass, i : integer;
        temp : handphone;
    begin
        for pass := 1 to n do
        begin
            for i := 1 to n - pass do
            begin
                if t[i].harga > t[i + 1].harga then
                begin
                    temp := t[i];
                    t[i]:= t[i + 1];
                    t[i + 1] := temp;
                end;
            end;
        end;
    end;

    procedure selectionSort5(var t : tabHp; n : integer);
    {I.S terdefinisi t
    F.S t sudah terurut}
    var
        pass, i, i_min : integer;
        temp : handphone;
    begin
        for pass := 1 to n do
        begin
            i_min := pass;
            for i := i_min + 1 to n do
            begin
                if t[i].stok < t[i_min].stok then
                begin
                    i_min := i;
                end;
            end;
            temp := t[pass];
            t[pass] := t[i_min];
            t[i_min] := temp;
        end;
    end;

    procedure insertionSort4(var t : tabHp; n : integer);
    {I.S terdefinisi tabel t
    mengurutkan isi tabel
    F.S diperoleh tabel t telat terurut}
    var
        pass, i : integer;
        temp : handphone;
    begin
        for pass := 1 to n do
        begin
            i := pass + 1;
            temp := t[i];
            while (temp.stok > t[i - 1].stok) and (i > 1) do
            begin
                t[i] := t[i - 1];
                i := i - 1;
            end;
            t[i] := temp;
        end;
    end;

    procedure menuSelect(var pil : integer; var t : tabHp; var stk : integer; var idx : integer; var n : integer);
    {I.S -
    F.S menampilkan menu untuk aplikasi, dimana menu bisa dipilih dan
    menampilkan data}
    var
        i : integer;
        key, sKey : string;
        key1 : longint;
        angka : integer;
    begin
        repeat
            clrscr;
            writeln('=========== [GUDANG WINDS HANDPHONE] ===========');
            writeln('================================================');
            writeln('=================== [MENU] =====================');
            writeln('== 1. Input Produk                            ==');
            writeln('== 2. Update Stok                             ==');
            writeln('== 3. Hapus Produk                            ==');
            writeln('== 4. Informasi Stok(terbanyak -> tersedikit) ==');
            writeln('== 5. Informasi Stok(tersedikit -> terbanyak) ==');
            writeln('== 6. Harga Produk(termurah -> termahal)      ==');
            writeln('== 7. Cek Produk                              ==');
            writeln('== 8. Log out                                 ==');
            writeln('================================================');
            writeln('=================== [ADMIN] ====================');
            writeln('================================================');
            write('Select Menu : ');
            readln(pil);
            case pil of
                1 : begin
                        write('Banyak Produk masuk : ');
                        readln(n);
                        for i := 1 to n do
                            begin
                                    write('Merk         : ');
                                    readln(t[i].merk);
                                    write('Stok         : ');
                                    readln(t[i].stok);
                                    write('Harga satuan : ');
                                    readln(t[i].harga);
                            end;
                        readln;
                    end;


                2 : begin
                            write('Merk : ');
                            readln(key);
                            idx := cariProduk(tabelHp, key, m);
                            if not ( idx = -1 ) then
                            begin
                                write('Update Stok : ');
                                readln(stk);
                                t[idx].stok := stk;
                                writeln ('Produk sudah di update ! ');
                            end
                            else
                            begin
                                writeln('Produk Kosong');
                            end;
                            readln;
                        end;

                
                3 : begin
                        write('Cari produk yang ingin dihapus : ');
                        readln(key);
                        printProduk(tabelHp);
                        write('Apakah anda yakin [Y/N] : ');
                        readln(x);
                        if (x = 'Y') then
                        begin
                            angka := cariProduk(tabelHp, key, n);
                            hapusProduk(tabelHp, n, angka);
                            writeln (n);
                        end
                        else
                            writeln('=============== DIBATALKAN ==================');
                        readln;
                        end;



                4 : begin
                            insertionSort4(tabelHp, m);
                            printProduk(tabelHp);
                        readln;
                        end;


                5 : begin
                        selectionSort5(t, n);
                        printProduk(t);
                        readln;
                    end;


                6 : begin
                        bubbleSort6(tabelHp, n);
                        printProduk(tabelHp);
                        writeln('================================================');
                        readln;
                    end;


                7 : begin
                        bubbleSort6(tabelHp,n);
                        write('Masukan Harga Produk : ');
                        readln(key1);
                        angka := binarySearch(t,n,key1);
                        if (angka = -1) then 
                            writeln('Produk kosong!')
                        else 
                        begin
                            writeln (t[angka].merk);
                            writeln(t[angka].stok);
                            writeln(t[angka].harga);
                        end;
                        readln;
                    end;


                8 : begin
                        writeln('================================================');
                        writeln('================================================');
                        writeln('================ KEEP SPIRIT!! =================');
                        writeln('================================================');
                        writeln('================================================');
                        readln;
                    end;
        end;
        until(pil = 8);    
    end;

begin
    menuSelect(pilih, tabelHp, stk, idx, m);
end.