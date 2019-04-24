program PemilihanRektor;
const maxrect = 23;
type 
    calon = record
            nama : string;
            noUrut : integer;
            skor : integer;
        end;
type tabelCalon = array [1..maxrect] of calon;

    function search(t : tabelCalon; n : integer; x : string) : integer;
    { Mengembalikan index array T apabila ditemukan calon dengan nama X,
    dan -1 apabila nama X tidak ditemukan. Gunakan SEQUENTIAL SEARCH!}
    var
        i, idx : integer;
    begin
        for i := 1 to n do 
        begin
            if t[i].nama = x then
            begin
               idx := 1; 
            end
            else
            begin
                idx := -1;
            end;
        end;
        search := idx;
    end;

    procedure sortSkor(var t : tabelCalon; var n : integer);
    {I.S. Terdefinisi tabel calon T dan jumlahnya N, mungkin tidak terurut
    F.S. tabel calon T terurut DESCENDING. Gunakan SELECTION SORT/INSERTION SORT}
    var
        pass, i, i_max : integer;
        temp : calon;
    begin
        for pass := 1 to n - 1 do
        begin
            i_max := pass;
            for i := i_max + 1 to n do
            begin
                if t[i].skor > t[i_max].skor then
                begin
                    i_max := i;
                end;
            end;
        temp := t[pass];
        t[pass] := t[i_max];
        t[i_max] := temp;                
        end;
    end;

    procedure daftarkanCalon(var t : tabelCalon; var n : integer);
    {I.S. Terdefinisi tabel calon T dan jumlahnya N,
    F.S. tabel calon T berisi calon sebanyak N}
    var
        i : integer;
    begin
        write('Masukan jumlah Calon : ');
        readln(n);
        for i := 1 to n do
        begin
            write('No. urut calon : ');
            readln(t[i].noUrut);
            write('Nama calon : ');
            readln(t[i].nama);
        end;
    end;

    procedure tampilkanCalon(var t : tabelCalon; var n : integer);
    {I.S. Terdefinisi tabel calon T dan jumlahnya N,
    F.S. menampilkan informasi semua calon dalam tabel calon T}
    var
        i : integer;
    begin
        for i := 1 to n do
        begin
            writeln('Calon no. urut ke-',t[i].noUrut,' : ',t[i].nama,' (Skor : ',t[i].skor,')');
        end;
    end;

    procedure pilrek(var t : tabelCalon; n : integer);
    {I.S. Terdefinisi tabel calon T dan jumlahnya N,
    F.S. set skor untuk setiap calon}
    var
        i : integer;
    begin
        for i := 1 to n do
        begin
            writeln('Calon no. urut ',t[i].noUrut,' nama ',t[i].nama);
            write('Masukan skor : ');
            readln(t[i].skor);
        end;
    end;

    procedure tampilkanCalonLolos(T: tabelCalon; N: integer);
    {I.S. Terdefinisi tabel calon T dan jumlahnya N,
    F.S. menampilkan informasi untuk calon yang LOLOS ke TAHAP 2 dalam tabel
    calon T}
    begin
        for n := 1 to 3 do;
        begin
            sortSkor(t, n);
            tampilkanCalon(t,n);
        end;    
    end;

var 
    tCalon : tabelCalon;
    n : integer;

begin
    writeln('PEMILIHAN REKTOR');
    writeln;
    writeln('Daftarkan Calon!');
    daftarkanCalon(tCalon, n);
    writeln('Daftar Calon yang Terdaftar');
    tampilkanCalon(tCalon, n);
    writeln;
    writeln('Pengisian Skor Calon');
    pilrek(tCalon,n);
    sortSkor(tCalon, n);
    writeln;
    writeln('Hasil Pelaksanaan Pilrek');
    tampilkanCalon(tCalon, n);
    writeln;
    writeln('Daftar Calon yang lolos ke tahap 2');
    tampilkanCalonLolos(tCalon, n);
end.