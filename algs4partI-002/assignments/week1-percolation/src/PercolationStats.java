
public class PercolationStats {

    private double[] thresholds;

    private int N;

    // perform T independent computational experiments on an N-by-N grid
    public PercolationStats(int N, int T) {
        if (N <= 0) {
            throw new IllegalArgumentException("N must be greater than 0");
        }
        if (T <= 0) {
            throw new IllegalArgumentException("T must be greater than 0");
        }

        this.N = N;

        thresholds = new double[T];

        Percolation percolation;

        for (int t = 0; t < T; t++) {
            percolation = new Percolation(N);

            int o = 0;
            while (!percolation.percolates()) {

                int i = StdRandom.uniform(1, N + 1);
                int j = StdRandom.uniform(1, N + 1);

                if (!percolation.isOpen(i, j)) {
                    percolation.open(i, j);
                    o++;
                }

            }
            thresholds[t] = o;
        }
    }

    // sample mean of percolation threshold
    public double mean() {
        return StdStats.mean(getThresholdPercentages());
    }

    // sample standard deviation of percolation threshold
    public double stddev() {
        return StdStats.stddev(getThresholdPercentages());
    }

    private double[] getThresholdPercentages() {
        double NN = ((double) N * (double) N);
        double[] tmp = new double[thresholds.length];
        for (int i = 0; i < thresholds.length; i++) {
            tmp[i] = thresholds[i] / NN;
        }
        return tmp;
    }

    // returns lower bound of the 95% confidence interval
    public double confidenceLo() {
        return mean() - ((1.96 * stddev()) / Math.sqrt(thresholds.length));
    }

    // returns upper bound of the 95% confidence interval
    public double confidenceHi() {
        return mean() + ((1.96 * stddev()) / Math.sqrt(thresholds.length));
    }

    // test client, described below
    public static void main(String[] args) {

        int N = Integer.parseInt(args[0]);
        int T = Integer.parseInt(args[1]);

        PercolationStats stats = new PercolationStats(N, T);
        StdOut.println("mean\t\t\t\t\t\t= " + stats.mean());
        StdOut.println("stddev\t\t\t\t\t\t= " + stats.stddev());
        StdOut.println(
                "95% confidence interval\t\t= " +
                        stats.confidenceLo() + ", " + stats.confidenceHi()
        );

    }

}
