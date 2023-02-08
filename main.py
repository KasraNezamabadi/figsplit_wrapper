import matlab.engine
import argparse

parser = argparse.ArgumentParser()

parser.add_argument("--matlab_path", help='Path to the folder containing FigSplit.m')
parser.add_argument("--image_path", help='Path to the image to be processed')

args = parser.parse_args()

eng = matlab.engine.start_matlab()
eng.cd(args.matlab_path, nargout=0)
eng.FigSplit(args.image_path, nargout=0)
