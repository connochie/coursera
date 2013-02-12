
public class Percolation {

    private int width;

    private QuickUnionUF uf;

    private int[][] grid;

    // create N-by-N grid, with all sites blocked
    public Percolation(int N) {
        width = N;

        uf = new QuickUnionUF(N * N);

        grid = new int[N][N];
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                grid[i][j] = 0;
            }
        }
    }

    // open site (row i, column j) if it is not already
    public void open(int i, int j) {

//        i -= 1;
//        j -= 1;

        if (!isOpen(i, j)) {

            // mark as open
            grid[i - 1][j - 1] = 1;

            // array[width * row + col] = value;

            // id of this newly opened site
            int id = (width * (i - 1)) + j - 1;

            // top
            if (isOpen(i - 1, j)) {
                int top = (width * (i - 2)) + j - 1;
                System.out.println("Unioning " + id + " " + top);
                uf.union(id, top);
            }

            // right
            if (isOpen(i, j + 1)) {
                int right = (width * (i - 1)) + j + 1;
                System.out.println("Unioning " + id + " " + right);
                uf.union(id, right);
            }

            // bottom
            if (isOpen(i + 1, j)) {
                int bottom = (width * i) + j - 1;
                System.out.println("Unioning " + id + " " + bottom);
                uf.union(id, bottom);
            }

            // left
            if (isOpen(i, j - 1)) {
                int left = (width * (i - 1)) + j - 2;
                System.out.println("Unioning " + id + " " + left);
                uf.union(id, left);
            }

        }
    }

    // is site (row i, column j) open?
    public boolean isOpen(int i, int j) {

        if (1 > i || i > width || 1 > j || j > width) {
//            throw new IndexOutOfBoundsException(
//                    String.format("Invalid grid indices: %d,%d", i, j)
//            );

            return false;
        }

        return grid[i - 1][j - 1] == 1;
    }

    // is site (row i, column j) full?
    public boolean isFull(int i, int j) {
        return false;
    }

    // does the system percolate?
    public boolean percolates() {

        print();

        for (int i = ((width * width) - width); i < (width * width); i++) {
            for (int j = 0; j < width; j++) {
                if (uf.connected(i, j)) {
                    System.out.println("Percolates? Yes.");
                    return true;
                }
            }
        }

        System.out.println("Percolates? No.");

        return false;
    }

    private void print() {
        System.out.println();

        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid.length; j++) {
                System.out.print(grid[i][j] + " ");
            }
            System.out.println();

        }

        System.out.println();

        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid.length; j++) {
                System.out.print(((i * grid.length) + j) + "\t");
            }
            System.out.println();

        }
        System.out.println();

    }
}