# -----------------------------
# 1. Base image: AWS Lambda Python 3.13
# -----------------------------
FROM public.ecr.aws/lambda/python:3.13

# -----------------------------
# 2. Copy Python dependencies file
# -----------------------------
COPY requirements.txt .

# -----------------------------
# 3. Install dependencies inside the container
# -----------------------------
RUN pip install --no-cache-dir -r requirements.txt

# -----------------------------
# 4. Copy Lambda handler and model
# -----------------------------
COPY lambda_function.py model.bin ./

# -----------------------------
# 5. Set Lambda handler
# -----------------------------
CMD ["lambda_function.lambda_handler"]
