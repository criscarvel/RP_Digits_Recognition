function asoc = asociar(centers, centerTest, YTest)

    asoc = [];
    for i = 1:size(centers,2)
        [~, u] = find(centerTest == i);
        clases = YTest(u);
        asoc = [asoc mode(clases)];
    end
        

end