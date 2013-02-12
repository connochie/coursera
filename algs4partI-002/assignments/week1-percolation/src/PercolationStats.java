
public class PercolationStats {

    // perform T independent computational experiments on an N-by-N grid
    public PercolationStats(int N, int T) {


    }

    // sample mean of percolation threshold
    public double mean() {
        return 0;
    }

    // sample standard deviation of percolation threshold
    public double stddev() {
        return 0;
    }

    // returns lower bound of the 95% confidence interval
    public double confidenceLo() {
        return 0;

    }

    // returns upper bound of the 95% confidence interval
    public double confidenceHi() {
        return 0;
    }

    // test client, described below
    public static void main(String[] args) {

        Percolation percolation = new Percolation(9);

        percolation.open(1, 2);
        percolation.open(2, 2);
        percolation.open(3, 2);
        percolation.open(3, 3);
        percolation.open(4, 3);
        percolation.open(5, 3);
        percolation.open(6, 3);
        percolation.open(7, 3);
        percolation.open(7, 4);
        percolation.open(8, 4);
        percolation.open(9, 4);

        boolean isFull = percolation.isFull(5,3);
        boolean isNotFull = percolation.isFull(5,4);

        percolation.print();
        boolean percolates = percolation.percolates();
        System.out.println("Percolates? " + (percolates ? "Yes." : "No."));
    }

}
