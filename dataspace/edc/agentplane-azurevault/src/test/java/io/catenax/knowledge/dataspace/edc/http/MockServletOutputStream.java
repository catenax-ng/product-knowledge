//
// EDC Data Plane Agent Extension Test
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.http;

import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.WriteListener;
import jakarta.validation.constraints.NotNull;

/**
 * Mock implementation of ServletOutputStream
 */
public class MockServletOutputStream extends ServletOutputStream {

	private final OutputStream delegate;

	public MockServletOutputStream(OutputStream stream) {
		this.delegate = stream;
	}

	public final OutputStream getdelegate() {
		return this.delegate;
	}

	@Override
	public void write(int b) throws IOException {
		this.delegate.write(b);
	}

	@Override
	public void write(@NotNull byte[] b) throws IOException {
		this.delegate.write(b);
	}

	@Override
	public void write(@NotNull byte[] b, int from, int length) throws IOException {
		this.delegate.write(b, from, length);
	}

    @Override
	public void flush() throws IOException {
		super.flush();
		this.delegate.flush();
	}

	@Override
	public void close() throws IOException {
		super.close();
		this.delegate.close();
	}

	@Override
	public boolean isReady() {
		return true;
	}

	@Override
	public void setWriteListener(WriteListener writeListener) {
		throw new UnsupportedOperationException();
	}

}